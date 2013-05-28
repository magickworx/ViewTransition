/*****************************************************************************
 *
 * FILE:	PageViewController.m
 * DESCRIPTION:	ViewTransition: Page View Controller
 * DATE:	Tue, May 28 2013
 * UPDATED:	Tue, May 28 2013
 * AUTHOR:	Kouichi ABE (WALL) / 阿部康一
 * E-MAIL:	kouichi@MagickWorX.COM
 * URL:		http://www.MagickWorX.COM/
 * COPYRIGHT:	(c) 2013 阿部康一／Kouichi ABE (WALL), All rights reserved.
 * LICENSE:
 *
 *  Copyright (c) 2013 Kouichi ABE (WALL) <kouichi@MagickWorX.COM>,
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *   1. Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *   2. Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *   THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 *   ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 *   THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 *   PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
 *   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *   INTERRUPTION)  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 *   THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Id: PageViewController.m,v 1.2 2013/01/22 15:23:51 kouichi Exp $
 *
 *****************************************************************************/

#import "PageViewController.h"
#import "ContentsViewController.h"

@interface PageViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource>
{
@private
  UIPageViewController *	_pageViewController;
  NSInteger			_pageIndex;
  NSInteger			_pageMax;
  NSInteger			_tempIndex;
}
@property (nonatomic,retain) UIPageViewController *	pageViewController;
@property (nonatomic,assign) NSInteger			pageIndex;
@property (nonatomic,assign) NSInteger			pageMax;
@property (nonatomic,assign) NSInteger			tempIndex;
@end

@implementation PageViewController

-(id)init
{
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"PageViewController", @"");
  }
  return self;
}

-(void)dealloc
{
  [_pageViewController release];
  [super dealloc];
}

-(void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)viewDidLoad
{
  [super viewDidLoad];

  _pageIndex	= 1;
  _pageMax	= 10;
  _tempIndex	= 1;

  UIPageViewController *	pageViewController;
  pageViewController = [[UIPageViewController alloc]
			initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
			navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
			options:nil];
  pageViewController.delegate	= self;
  pageViewController.dataSource	= self;
  pageViewController.view.frame	= self.view.bounds;

  ContentsViewController *	contentsViewController;
  contentsViewController = [ContentsViewController new];

  NSArray *	viewControllers = @[contentsViewController];
  [pageViewController setViewControllers:viewControllers
		      direction:UIPageViewControllerNavigationDirectionForward
		      animated:YES
		      completion:nil];
  [contentsViewController release];

  [self addChildViewController:pageViewController];

  [self.view addSubview:pageViewController.view];
  [pageViewController didMoveToParentViewController:self];

  self.view.gestureRecognizers = pageViewController.gestureRecognizers;

  self.pageViewController = pageViewController;
  [pageViewController release];
}

/*****************************************************************************/

#pragma mark UIPageViewControllerDelegate
// Sent when a gesture-initiated transition begins.
-(void)pageViewController:(UIPageViewController *)pageViewController
	willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
#if	0
  NSLog(@"DEBUG[pending] %@",pendingViewControllers);
#endif
}


#pragma mark UIPageViewControllerDelegate
/*
 * Sent when a gesture-initiated transition ends. The 'finished' parameter
 * indicates whether the animation finished, while the 'completed' parameter
 * indicates whether the transition completed or bailed out (if the user let
 * go early).
 */
-(void)pageViewController:(UIPageViewController *)pageViewController
	didFinishAnimating:(BOOL)finished
	previousViewControllers:(NSArray *)previousViewControllers
	transitionCompleted:(BOOL)completed
{
  ContentsViewController *	contentsViewController;
  contentsViewController = [previousViewControllers objectAtIndex:0];
  if (finished) {
#if	0
    NSLog(@"DEBUG[finished] %@",previousViewControllers);
#endif
  }
  if (completed) {
#if	0
    NSLog(@"DEBUG[completed] %@",previousViewControllers);
#endif
    _pageIndex = _tempIndex;
  }
  [contentsViewController setPageIndex:_pageIndex];
}

#pragma mark UIPageViewControllerDataSource
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
  if (_pageIndex == 1) {
    return nil;
  }
  _tempIndex = _pageIndex - 1;

  ContentsViewController *	contentsViewController;
  contentsViewController = [ContentsViewController new];
  contentsViewController.view.backgroundColor = [UIColor whiteColor];
  [contentsViewController setPageIndex:_tempIndex];

  return [contentsViewController autorelease];
}

#pragma mark UIPageViewControllerDataSource
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
  if (_pageIndex == _pageMax) {
    return nil;
  }
  _tempIndex = _pageIndex + 1;

  ContentsViewController *	contentsViewController;
  contentsViewController = [ContentsViewController new];
  contentsViewController.view.backgroundColor = [UIColor whiteColor];
  [contentsViewController setPageIndex:_tempIndex];

  return [contentsViewController autorelease];
}

@end
